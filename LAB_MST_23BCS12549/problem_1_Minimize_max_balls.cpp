#include <bits/stdc++.h>
using namespace std;

int minimumPenalty(vector<int>& nums, int maxOperations) {
    int low = 1;
    int high = *max_element(nums.begin(), nums.end());
    int ans = high;

    while (low <= high) {
        int mid = (low + high) / 2;
        long long ops = 0;

        for (int x : nums)
            ops += (x - 1) / mid;

        if (ops <= maxOperations) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

int main() {
    vector<int> nums = {9};
    int maxOperations = 2;
    cout << minimumPenalty(nums, maxOperations);
}
