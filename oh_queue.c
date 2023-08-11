// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "oh_queue.h"

struct Queue oh_queue;

/** push
 * @brief Create a new student and push him
 * onto the OH queue
 * @param studentName pointer to the student's name
 * @param topicName topic the student has a question on
 * @param questionNumber hw question number student has a question on
 * @param pub_key public key used for calculating the hash for customID
 * @return FAILURE if the queue is already at max length, SUCCESS otherwise
 */
int push(const char *studentName, const enum subject topicName, const float questionNumber, struct public_key pub_key){
    
    if (oh_queue.stats.no_of_people_in_queue >= MAX_QUEUE_LENGTH)
    {
        return FAILURE;
    }
    if (studentName == NULL)
    {
        return FAILURE;
    }

    char name[MAX_NAME_LENGTH];
    my_strncpy(name, studentName, MAX_NAME_LENGTH - 1);
    name[MAX_NAME_LENGTH - 1] = '\0';

    int ciphertext[MAX_NAME_LENGTH];
    hash(ciphertext, name, pub_key);

    int number = oh_queue.stats.no_of_people_in_queue + oh_queue.stats.no_of_people_visited;

    struct Topic tp;
    tp.questionNumber = questionNumber;
    tp.topicName = topicName;
    struct StudentData data; 
    my_strncpy(data.name, name, (size_t)MAX_NAME_LENGTH);
    data.topic = tp;
    struct Student next; 
    for (int i = 0; i < MAX_NAME_LENGTH; i++)
    {
        next.customID[i] = ciphertext[i];
    }
    next.queue_number = number;
    next.studentData = data;
    oh_queue.students[oh_queue.stats.no_of_people_in_queue] = next;

    oh_queue.stats.no_of_people_in_queue++;
    struct OfficeHoursStats *resultStats = &(oh_queue.stats);
    OfficeHoursStatus(resultStats);

    return SUCCESS;
}

/** pop
 * @brief Pop a student out the OH queue
 * @return FAILURE if the queue is already at empty, SUCCESS otherwise
 */
int pop(void) {
    if (oh_queue.stats.no_of_people_in_queue == 0)
    {
        return FAILURE;
    }
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue - 1; i++) {
        oh_queue.students[i] = oh_queue.students[i+1];
    }
    oh_queue.stats.no_of_people_visited++;
    oh_queue.stats.no_of_people_in_queue--;
    struct OfficeHoursStats *resultStats = &(oh_queue.stats);
    OfficeHoursStatus(resultStats);
    return SUCCESS;
}

/** group_by_topic
 * @brief Push pointers to students, who match the given topic, to
 * the given array "grouped"
 * @param topic the topic the students need to match
 * @param grouped an array of pointers to students
 * @return the number of students matched
 */
int group_by_topic(struct Topic topic, struct Student *grouped[]) { 
    int number = 0;
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        if (oh_queue.students[i].studentData.topic.questionNumber == topic.questionNumber &&
            oh_queue.students[i].studentData.topic.topicName == topic.topicName) {
                grouped[number] = &(oh_queue.students[i]);
                number++;
        }
    }
    return number;

}

/** hash
 * @brief Creates a hash based on pub_key provided
 * @param ciphertext the pointer where you will store the hashed text
 * @param plaintext the originak text you need to hash
 * @param pub_key public key used for calculating the hash
 */
void hash(int *ciphertext, char *plaintext, struct public_key pub_key) {
    int n = pub_key.n;
    int e = pub_key.e;
    for (int i = 0; i < (int)my_strlen(plaintext); i++)
    {
        ciphertext[i] = power_and_mod(plaintext[i], e, n);
    }
    return;
}

/** update_student
 * @brief Find the student with the given ID and update his topic
 * @param customID a pointer to the id of the student you are trying to find
 * @param newTopic the new topic that should be assigned to him
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int update_student(struct Topic newTopic, int *customID) {
    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        if (my_strncmp((char *)oh_queue.students[i].customID, (char *)customID, MAX_NAME_LENGTH) == 0) {
            oh_queue.students[i].studentData.topic = newTopic;
            return SUCCESS;
        }
    }
    return FAILURE;
}

/** remove_student_by_name
 * @brief Removes first instance of a student with the given name
 * @param name the name you are searching for
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_name(char *name){
    int j = -1;

    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        if (my_strncmp(oh_queue.students[i].studentData.name, name, MAX_NAME_LENGTH) == 0) {
            j = i;
            break;
        }
    }

    if(j == -1) {
        return FAILURE;
    }

    for (int i = j; i < oh_queue.stats.no_of_people_in_queue - 1; i++) {
        oh_queue.students[i] = oh_queue.students[i+1];
    }

    oh_queue.stats.no_of_people_visited++;
    oh_queue.stats.no_of_people_in_queue--;
    struct OfficeHoursStats *resultStats = &(oh_queue.stats);
    OfficeHoursStatus(resultStats);

    return SUCCESS;
}

/** remove_student_by_topic
 * @brief Remove all instances of students with the given topic
 * @param topic the topic you are trying to remove from the queue
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_topic(struct Topic topic) {
    int x = -1;

    for (int i = 0; i < oh_queue.stats.no_of_people_in_queue; i++) {
        if (oh_queue.students[i].studentData.topic.questionNumber == topic.questionNumber &&
            oh_queue.students[i].studentData.topic.topicName == topic.topicName) {
            x = 0;
            for (int j = i; j < oh_queue.stats.no_of_people_in_queue - 1; j++) {
                oh_queue.students[j] = oh_queue.students[j+1];
            }
            oh_queue.stats.no_of_people_visited++;
            oh_queue.stats.no_of_people_in_queue--;
        }
    }

    if(x == -1) {
        return FAILURE;
    }

    oh_queue.stats.no_of_people_in_queue--;
    struct OfficeHoursStats *resultStats = &(oh_queue.stats);
    OfficeHoursStatus(resultStats);
    return SUCCESS;
}

/** OfficeHoursStatus
 * @brief Updates the "currentStatus" field based on
 * whether or not all students in the queue have been helped
 * @param resultStats A pointer the OfficeHoursStats variable
 * you are to update
 */
void OfficeHoursStatus(struct OfficeHoursStats* resultStats){
    if (resultStats->no_of_people_in_queue <= 0) {
        resultStats->currentStatus = "Completed";
    } else {
        resultStats->currentStatus = "InProgress";
    }
    return;
}

/*
 * Calculates (b^e)%n without overflow
 */
int power_and_mod(int b, int e, int n) {
    long int currNum = 1;
    for (int i = 0; i < e; i++) {
        currNum *= b;
        if (currNum >= n) {
            currNum %= n;
        }
    }
    return (int) (currNum % n);
}