#include "../prelude.cc"

int main() {
  let double d = 2.0;
  printDouble(d);
  d++;
  printDouble(d);
  d--;
  printDouble(d);

  return 0;
}
