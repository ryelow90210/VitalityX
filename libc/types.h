#ifndef TYPES_H
#define TYPES_H

///
/// Unsigned 8-bit Integer
///
typedef unsigned char uint8_t;
///
/// Signed 8-bit Integer
///
typedef char sint8_t;
///
/// Unsigned 32-bit Integer
///
typedef unsigned short uint16_t;
///
/// Signed 16-bit Integer
///
typedef short sint16_t;
///
/// Unsigned 32-bit Integer
///
typedef unsigned int uint32_t;
///
/// Signed 32-bit Integer
///
typedef int sint32_t;
///
/// Unsigned 64-bit Integer
///
typedef unsigned long uint64_t;
///
/// Signed 64-bit Integer
///
typedef long sint64_t;
#ifndef CPP
///
/// Boolean Value, true or false
///
typedef enum { false, true } bool;
#endif
///
/// Address Pointer
///
typedef uint32_t *addr_t;
///
/// Size Container
///
typedef uint32_t size_t;

///
/// Gets the High 16 bits of a number
///
#define low_16(address) (uint16_t)((address) & 0xFFFF)
///
/// Gets the Low 16 bits of a number
///
#define high_16(address) (uint16_t)(((address) >> 16) & 0xFFFF)

#define NULL 0

#define USHRT_MAX 65535 

#endif