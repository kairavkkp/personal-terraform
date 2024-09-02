package main

import "fmt"

func findMedianSortedArrays(nums1 []int, nums2 []int) float64{
    
    l1, l2 := len(nums1), len(nums2)
    i, j := 0, 0
    result := make([]int, l1 + l2)

    curr := 0    
    for i < l1 && j < l2 {
        if nums1[i] < nums2[j] {
            result[curr] = nums1[i]
            curr++
            i++
        } else {
            result[curr] = nums2[j]
            curr++
            j++
        }
    }
    
    for i < l1 {
        result[curr] = nums1[i]
        curr++
        i++
    }

    for j < l2 {
        result[curr] = nums2[j]
        curr++
        j++
    }
	fmt.Println(result)
    if len(result) % 2 != 0 {
        index := (len(result) + 1) / 2
        return float64(result[index - 1])
    } else {
        index := len(result) / 2
        return float64(result[index - 1] + result[index]) / 2.0
    }
}

func main() {
	result := findMedianSortedArrays([]int{1,2}, []int{3,4})
	fmt.Println(result)
}