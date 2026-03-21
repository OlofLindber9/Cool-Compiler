// Throw conditionally inside a loop.
int main() {
  int i = 0;
  int caught = 0;
  while (i < 5) {
    try {
      if (i == 3) {
        throw i;
      } else {
        i = i + 1;
      }
    } catch (int e) {
      caught = e;
      i = i + 1;
    }
  }
  printInt(caught);
  return 0;
}
