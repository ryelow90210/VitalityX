# Information on VAM

Currently in the thought stage, VAM will run as cooperative tasks next to the kernel which will handle their own interrupts and be able to run effectively multiple kernels on one kernel.

Heres a theoretical model on how it should work:

```
+----------------+       returns control
|VitalityX kernel<-----------------------------------+
+---+------------+                                   |
    |                                                |
    |gives control                                   |
    |                                                |
    |                                                |
    |                                                |
    |                                                |
    |                                                |
    |                                                |
    |                                                |
    |                                                |
    |                                                |
+---v---+ gives control +-------+  gives control +---+--+
|VAM 0  |               | VAM 1 |                |VAM 2 |
|Windows+---------------> Linux +---------------->Mac OS|
+-------+               +-------+                +------+
```