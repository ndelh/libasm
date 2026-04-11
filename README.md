# 📁 LIBASM - 42 Assembly Initiation Project

**LIBASM** is an introductory project to x86_64 assembly. The goal is to acquire foundational low-level programming knowledge by rewriting standard `libc` functions.

---

## 🧠 Core Notions

### 1. Registries (Registers)
Think of registers as a set of ultra-fast **global pointers** built directly into the CPU.
* **Dedicated Roles**: Some registers have specific purposes (e.g., `rax` stores the return value, `rdi` holds the 1st argument).
* **Dereferencing**: `rax` refers to the memory address, while `[rax]` refers to the data stored at that address.
* **Sizes & Sub-registers**: 
    * A full register is **64 bits** (8 bytes).
    * `eax` refers to the lower 4 bytes of `rax`.
    * `al` refers to the lowest single byte.
    > ⚠️ **Warning**: Using the wrong register size for a data type (e.g., checking `rax` instead of `eax` for a 32-bit `int`) can cause **Undefined Behavior (UB)**.

### 2. Calling Convention
It is vital to know which registers must be protected during function calls:
* **Caller-saved (e.g., `rsi`, `rdi`, `rdx`)**: The function *calling* another must save these if it needs to reuse the data later.
* **Callee-saved (e.g., `rbx`, `r12` to `r15`)**: If your function uses these, it **must** restore their original values before returning (typically using `push` and `pop`).

### 3. Flags & Jumps
Most logic flows through a **Flag** system.
* `cmp [rax], 0` sets comparison flags in the CPU.
* Conditional jump instructions then read these flags:
    * `je` (Equal), `jne` (Not Equal).
    * `ja` / `jb` (Above/Below - Unsigned).
    * `jg` / `jl` (Greater/Less - Signed).

---

## 🛠 Implemented Functions

### Mandatory Functions
| Function | Technical Note |
| :--- | :--- |
| **ft_strlen** | Simple char iteration, but can be optimized using **SWAR** (8 bytes at a time). |
| **ft_strcpy** | Essentially `strlen` with an extra step. Can copy registry by registry if optimized. |
| **ft_strcmp** | **Note**: Valgrind hooks libc functions; test your version with and without it. |
| **ft_read / ft_write** | Learn to trigger **syscalls** and set `errno` via `__errno_location`. |
| **ft_strdup** | Calls `malloc`. **Critical**: The stack must be **16-byte aligned** before the call. |

### Bonus Functions (Lists & Sorting)
* **ft_atoi_base**: Optimized by creating an index lookup table directly on the stack (`rsp`) to avoid nested loops.
* **ft_list_push_front**: Direct manipulation of node offsets (`[rax]` for data, `[rax + 8]` for the next pointer). No real difficulty beside edge case
* **ft_list_size**: The simplest one, a basic linked list iteration.
* **ft_list_sort**: The "Final Boss." Simplest way to do it is by rebuilding the list and making an insertion sort. Suffering is expected and normal. Be smarther than me and dont loose 24h because you mistook rax for eax
* **ft_list_remove_if**: Require two distinct but basic logics. One for chain removing the head if needed. One for the body

---

## 🚀 Tips for Success

1.  **Optimization**: In assembly, small architectural mistakes snowball quickly. Think ahead to avoid bloated code.
2.  **Comment Everything**: Assembly is notoriously difficult to read, especially for beginners. **Commenting every single line** is the key to debugging.
3.  **Stack Alignment**: If your code crashes during a `call` to `malloc` or `printf`, your `rsp` is likely not a multiple of 16. This is a rite of passage for every ASM coder.

---
