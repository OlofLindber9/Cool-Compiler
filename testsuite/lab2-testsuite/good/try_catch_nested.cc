// Nested try/catch blocks.
int main() {
  try {
    try {
      throw 1;
    } catch (int inner) {
      printInt(inner);
      throw 2;
    }
  } catch (int outer) {
    printInt(outer);
  }
  return 0;
}
