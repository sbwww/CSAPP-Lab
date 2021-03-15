#include <bits/stdc++.h>
using namespace std;

int func4(int arg1, int arg2, int arg3, int arg4) {
  int res = arg3;
  res -= arg2;
  arg4 = res;
  arg4 >>= 31;
  res += arg4;
  res >>= 1;
  arg4 = res + arg2;
  if (arg4 <= arg1) {
    res = 0;
    if (arg4 >= arg1) {
      return res;
    } else {
      arg2 = 1 + arg4;
      res = func4(arg1, arg2, arg3, arg4);
      res = 1 + 2 * res;
      return res;
    }
  } else {
    arg3 = arg4 - 1;
    res = func4(arg1, arg2, arg3, arg4);
    res *= 2;
    return res;
  }
  return res;
}

int main() {
  for (int i = 0; i <= 14; ++i) {
    int ans = func4(i, 0, 14, 0);
    cout << i << " " << ans << endl;
  }
  return 0;
}

/** output
    0 0     yes
    1 0     yes
    2 4
    3 0     yes
    4 2
    5 2
    6 6
    7 0     yes
    8 1
    9 1
    10 5
    11 1
    12 3
    13 3
    14 7
**/