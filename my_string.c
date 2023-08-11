/**
 * @file my_string.c
 * @author Minkun Lei
 * @collaborator None
 * @brief Your implementation of these famous 3 string.h library functions!
 *
 * NOTE: NO ARRAY NOTATION IS ALLOWED IN THIS FILE
 *
 * @date 2023-03-27
 */

#include <stddef.h>
#include "my_string.h"

/**
 * @brief Calculate the length of a string
 *
 * @param s a constant C string
 * @return size_t the number of characters in the passed in string
 */
size_t my_strlen(const char *s)
{
    size_t length = 0;
    char element = *s;

    while (element != '\0')
    {
        length++;
        element = *(s + length);
    }

    return length;
}

/**
 * @brief Compare two strings
 *
 * @param s1 First string to be compared
 * @param s2 Second string to be compared
 * @param n First (at most) n bytes to be compared
 * @return int "less than, equal to, or greater than zero if s1 (or the first n
 * bytes thereof) is found, respectively, to be less than, to match, or be
 * greater than s2"
 */
int my_strncmp(const char *s1, const char *s2, size_t n)
{
    size_t index = 0;
    char element1 = *s1;
    char element2 = *s2;
    
    while (index < n) 
    {
        element1 = *(s1 + index);
        element2 = *(s2 + index);

        if (element1 < element2)
        {
            return -1;
        } 
        else if (element1 > element2)
        {
            return 1;
        }
        if (element1 == '\0' && element2 == '\0')
        {
            return 0;
        }

        index++;
    }

    return 0;
}

/**
 * @brief Copy a string
 *
 * @param dest The destination buffer
 * @param src The source to copy from
 * @param n maximum number of bytes to copy
 * @return char* a pointer same as dest
 */
char *my_strncpy(char *dest, const char *src, size_t n)
{
    size_t index = 0;
    char element = *src;
    
    while (index < n) 
    {
        element = *(src + index);
        *(dest + index) = element;
        if (element == '\0')
        {
            return dest;
        }
        index++;
    }
    
    return dest;
}

/**
 * @brief Concatenates two strings and stores the result
 * in the destination string
 *
 * @param dest The destination string
 * @param src The source string
 * @param n The maximum number of bytes from src to concatenate
 * @return char* a pointer same as dest
 */
char *my_strncat(char *dest, const char *src, size_t n)
{
    size_t length = my_strlen(dest);
    char *last = dest + length;

    size_t index = 0;
    char element = *src;
    while (index < n) 
    {
        element = *(src + index);
        *(last + index) = element;
        if (element == '\0')
        {
            return dest;
        }
        index++;
    }
    
    return dest;
}

/**
 * @brief Copies the character c into the first n
 * bytes of memory starting at *str
 *
 * @param str The pointer to the block of memory to fill
 * @param c The character to fill in memory
 * @param n The number of bytes of memory to fill
 * @return char* a pointer same as str
 */
void *my_memset(void *str, int c, size_t n)
{
    size_t index = 0;
    char *newstr = (char *)str;
    while (index < n) 
    {
        *(newstr + index) = c;
        index++;
    }
    
    return newstr;
}

/**
 * @brief Finds the first instance of c in str
 * and removes it from str in place
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 */
void remove_first_instance(char *str, char c){
    
    int index;

    for (int i = 0; (size_t)i < my_strlen(str); i++)
    {
        char curr = *(str + i);
        if (curr == c) {
            index = i;
            break;
        }
    }

    for (int i = index; (size_t)i < my_strlen(str); i++)
    {
        *(str + i) = *(str + i + 1);
    }
    
    return;
}

/**
 * @brief Finds the first instance of c in str
 * and replaces it with the contents of replaceStr
 *
 * @param str The pointer to the string
 * @param c The character we are looking to delete
 * @param replaceStr The pointer to the string we are replacing c with
 */
void replace_character_with_string(char *str, char c, char *replaceStr) {

    int index = -1;
    for (int i = 0; (size_t)i < my_strlen(str); i++)
    {
        char curr = *(str + i);
        if (curr == c) {
            index = i;
            break;
        }
    }

    if (index == -1)
    {
        return;
    }

    size_t insert = my_strlen(replaceStr) - 1;
    
    for (int i = (int)my_strlen(str); i >= index; i--)
    {
        *(str + i + insert) = *(str + i);
    }
    for (int i = 0; (size_t)i < my_strlen(replaceStr); i++)
    {
        *(str + i + index) = *(replaceStr + i);
    }
    
    return;
}

/**
 * @brief Remove the first character of str (ie. str[0]) IN ONE LINE OF CODE.
 * No loops allowed. Assume non-empty string
 * @param str A pointer to a pointer of the string
 */
void remove_first_character(char **str) {

    *str = *str + 1;
    
    return;
}