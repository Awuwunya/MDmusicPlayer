What is FW-KENSC
================

FW-KENSC is a collection of compression and decompression tools. It supports the
formats from KENS -- Kosinski, Enigma, Nemesis and Saxman -- but also supports
Comper, a compression format created by vladikcomper that has fast-decompression
speed as its primary goal. The FW stands for flamewing.

Advantages over KENS
====================

FW-KENSC is more portable, more legible, more efficient and has less bugs than
KENS; these were my core goals, I succeed at every turn!

The LZSS-based formats -- namely, Kosinski, Saxman and Comper -- boast perfect
compression: you can't write a compressor for these formats that will result in
a better compression ratio. And I did this by writing a generic adaptable LZSS-
backend that facilitates writing perfect compressors for these kinds of formats.

My Nemesis compressor also features better compression on all cases over KENS;
it is also much faster due to much better algorithms used to compress the data
stream. It is still possible to improve compression ratio, but very hard -- the
remaining issue is finding a better way to break up the input stream into tokens
to be be fed to the rest of the algorithm, as the current greedy strategy does
not always result in the smallest file size.

The least efficient compressor is the Enigma one -- for now, at least. However,
it has marginally better compression overall than the KENS one. Still a win, on
my estimation.

Since I made these public and made kram1024 aware of them, several of my changes
were incorporated into KENS -- but not all. Not yet, at any rate.

About FW-KENSC
==============

I started to make these tools so I could write my Sonic 2 Special Stage Editor,
which needs Kosinski and Nemesis compression and decompression capabilities.

I have been using Linux for years, and use Windows only if I have no choice; so
I wanted S2-SSEdit to work on Linux natively. This ruled out using KENS, which
uses dlls -- Windows-specific crap. So I went for KENS source code to include it
on my project. Big mistake.

The source was so bad that I had to resist the urge to claw out my eyes. It was
an undocumented, unportable mess, making assumptions that were broken by using
a 64-bit OS, among other problems. It even used GOTOs. In C++.

So I decided to rewrite them all.

The Nemesis compressor I simply threw away -- it was unsalvageable. Yes, it was
that bad. Instead, I read the Sega Retro documentation on the format and wrote a
compressor from scratch. I also threw away the decompressor and wrote my own,
for good measure.

The Kosinski and Enigma compressors and decompressors were not as bad; so I just
made more legible versions of them at first.

More recently, I made a brand-spanking new LZSS back-end which I then I used to
make Kosinski, Saxman and Comper compressors with perfect compression and much
less effort. The source is now much more documented and legible.

Relationship with KENSSharp
===========================

FraGag wrote KENSSharp using my code as basis; MainMemory needed to be able to
compress to/decompress from these formats to write SonLVL. SonLVL is in C#, so
KENS could not be used -- and neither could my versions.

Source
======
You can obtain the source code for these tools, and many others, at my Google
Code project: https://code.google.com/p/s2-ssedit/

