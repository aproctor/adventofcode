#!/usr/bin/env ruby


# To achieve this, begin with a list of numbers from 0 to 255, a current position which begins at 0 (the first element in the list), a skip size (which starts at 0), and a sequence of lengths (your puzzle input). Then, for each length:

# Reverse the order of that length of elements in the list, starting with the element at the current position.
# Move the current position forward by that length plus the skip size.
# Increase the skip size by one.