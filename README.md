
# PMAP

Linux kernel 2.6.32, gave Linux a feature called "Kernel SamePage Merging." This means Linux can detect identical regions of data in different address spaces. Imagine a series of virtual machines running on a single computer, and the virtual machines are all running the same operating system. Using a shared memory model and copy-on-write, the overhead on the host computer can be drastically reduced.

All of which makes the memory handling in Linux sophisticated. But difficult to look at a process and know what its memory usage really is.

The kernel exposes a lot of what it is doing with RAM through two pseudo-files in the "/proc" system information pseudo-filesystem. There are two files per process, named for the process ID or PID of each process:* "/proc/$PID/maps" and "/proc/$PID/smaps."

The [ anon ] value is anonymous memory mapping, which is part of the memory populated with data not taken from the filesystem but allocated when needed.

:vulcan_salute:

* *Address:* The beginning memory address allocation
* *Kbytes:* Memory allocation in kilobytes
* *RSS:* Resident set size of the process in memory
* *Dirty:* The status of the memory pages
* *Mode:* Access mode and privileges
* *Mapping:* The user-facing name of the application or library

* *r:* The mapped memory can be read by the process.
* *w:* The mapped memory can be written by the process.
* *x:* The process can execute any instructions contained in the mapped memory.
* *s:* The mapped memory is shared, and changes made to the shared memory are visible to all of the processes sharing the memory.
* *R:* There is no reservation for swap space for this mapped memory. 

* *Address:* The start address of this mapping. This uses virtual memory addressing.
* *Perm:* The permissions of the memory.
* *Offset:* If the memory is file-based, the offset of this mapping inside the file.
* *Device:* The Linux device number, given in major and minor numbers. You can see the device numbers on your computer by running the lsblk command.
* *Inode:* The inode of the file the mapping is associated with. For example, in our example, this could be the inode that holds information about the pm program.
* *Size:* The size of the memory-mapped region.
* *KernelPageSize:* The page size used by the kernel.
* *MMUPageSize:* The page size used by the memory management unit.
* *Rss:* This is the resident set size. That is, the amount of memory that is currently in RAM, and not swapped out.
* *Pss:* This is the proportional share size. This is the private shared size added to the (shared size divided by the number of shares.)
* *Shared_Clean:* The amount of memory shared with other processes that has not been altered since the mapping was created. Note that even if memory is shareable, if it hasn't actually been shared it is still considered private memory.
* *Shared_Dirty:* The amount of memory shared with other processes that has been altered since the mapping was created.
* *Private_Clean:* The amount of private memory---not shared with other processes---that has not been altered since the mapping was created.
* *Private_Dirty:* The amount of private memory that has been altered since the mapping was created.
* *Referenced:* The amount of memory currently marked as referenced or accessed.
* *Anonymous:* Memory that does not have a device to swap out to. That is, it isn't file-backed.
* *LazyFree:* Pages that have been flagged as MADV_FREE. These pages have been marked as available to be freed and reclaimed, even though they may have unwritten changes in them. However, if subsequent changes occur after the MADV_FREE has been set on the memory mapping, the MADV_FREE flag is removed and the pages will not be reclaimed until the changes are written.
* *AnonHugePages:* These are non-file backed "huge" memory pages (larger than 4 KB).
* *ShmemPmdMapped:* Shared memory associated with huge pages. They may also be used by filesystems that reside entirely in memory.
* *FilePmdMapped:* The Page Middle Directory is one of the paging schemes available to the kernel. This is the number of file-backed pages pointed to by PMD entries.
* *Shared_Hugetlb:* Translation Lookaside Tables, or TLBs, are memory caches used to optimize the time taken to access userspace memory locations. This figure is the amount of RAM used in TLBs that are associated with shared huge memory pages.
* *Private_Hugetlb:* This figure is the amount of RAM used in TLBs that are associated with private huge memory pages.
* *Swap:* The amount of swap being used.
* *SwapPss:* The swap proportional share size. This is the amount of swap made up of swapped private memory pages added to the (shared size divided by the number of shares.)
* *Locked:* Memory mappings can be locked to prevent the operating system from paging out heap or off-heap memory.
* *THPeligible:* This is a flag indicating whether the mapping is eligible for allocating transparent huge pages. 1 means true, 0 means false. Transparent huge pages is a memory management system that reduces the overhead of TLB page lookups on computers with a large amount of RAM.
* *VmFlags:* See the list of flags below.
* *Mapping:* The name of the source of the mapping. This can be a process name, library name, or system names such as stack or heap.

The VmFlags - will be a subset of the following list.

* *rd:* Readable.
* *wr:* Writeable.
* *ex:* Executable.
* *sh:* Shared.
* *mr:* May read.
* *mw:* May write.
* *me:* May execute.
* *ms:* May share.
* *gd:* Stack segment grows down.
* *pf:* Pure page frame number range. Page frame numbers are a list of the physical memory pages.
* *dw:* Disabled write to the mapped file.
* *lo:* Pages are locked in memory.
* *io:* Memory-mapped I/O area.
* *sr:* Sequential read advise provided (by the madvise() function.)
* *rr:* Random read advise provided.
* *dc:* Do not copy this memory region if the process is forked.
* *de:* Do not expand this memory region on remapping.
* *ac:* Area is accountable.
* *nr:* Swap space is not reserved for the area.
* *ht:* Area uses huge TLB pages.
* *sf:* Synchronous page fault.
* *ar:* Architecture-specific flag.
* *wf:* Wipe this memory region if the process is forked.
* *dd:* Do not include this memory region in core dumps.
* *sd:* Soft dirty flag.
* *mm:* Mixed map area.
* *hg:* Huge page advise flag.
* *nh:* No huge page advise flag.
* *mg:* Mergeable advise flag.
* *bt:* ARM64 bias temperature instability guarded page.
* *mt:* ARM64 Memory tagging extension tags are enabled.
* *um:* Userfaultfd missing tracking.
* *uw:* Userfaultfd wr-protect tracking.


