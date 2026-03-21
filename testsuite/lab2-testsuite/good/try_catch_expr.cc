// throw an expression result.
int double_it(int x) {
  return x * 2;
}

int main() {
  try {
    throw double_it(7);
  } catch (int e) {
    printInt(e);
  }
  return 0;
}
