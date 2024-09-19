Problem: Finding the k-th smallest element in an array

Review quicksort and partition subroutine.

```
Quicksort(A, p, r) {
    if (p < r) {
        q = Partition(A,p,r)
        Quicksort(A,p,q-1)
        Quicksort(A, ...

    }
}
```

Partition guarantees the pivot is placed in array such that all values to the 
left are smaller and those to the right are larger. 

This means one of two things

    1) if the k-th element is less than or greater than your pivot, you know which subset 
       of the list to recursively quicksort on.
    2) you got lucky and k is the index of your pivot.

```
int RandomizedSelect(int A[], int l, int r, int k) {
    if (1 == r) return A[l]
    int q = RandomizedPartition(A, l, r)
        if (q+1 == k) return A[q]
        else if (q+1 > k) return RandomizedSelect(A, ...

```

# Hashing
function: input -> int
    - given same input, ouput should always be the same
    - two different inputs should give wildly different outputs
    - should distribute outputs uniformly


