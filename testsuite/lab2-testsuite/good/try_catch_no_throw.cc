// try block that does NOT throw: catch should not execute.
int main() {
  int result = 0;
  try {
    result = 1;
  } catch (int e) {
    result = 99;
  }
  printInt(result);
  return 0;
}
