# Introduction

The package implements I/O for IceCube Public Data whose event bytestream is illustrated in [this page](https://icecube.umd.edu/PublicData/):

> 1. 4 bytes - runID(unsigned int)
> 2. 4 bytes - year(unsigned int)
> 3. 8 bytes - startTime (long) Number of tenths of nanoseconds since the beginning of the year.
> 4. 8 bytes - eventLength(float) - Units of microseconds.
> 5. 4 bytes - (long) - Number of triggers. This is not a member of the Event class, since it's simply the size of the trigger list. For each trigger the byte structure is given as :
>     1. 8 bytes - trigger time (float) - Time of the trigger with respect to the start of the event.
>     2. 4 bytes - nchar (int) - Number of characters in the trigger name.
>     3. nchar * 1 byte - The characters that make up the trigger name.
> 6. 8 bytes - nhits (long) - Number of hits in the event. The next set consists of nhits\*5\*8 bytes (one chunk of 8 bytes for each float of q,t,x,y,z).

Please note that there is a typo. The number of triggers (long) takes 8 bytes, instead of 4.

Read the [Demonstration](@ref) for more.
