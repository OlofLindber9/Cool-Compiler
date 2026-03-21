// Basic try/catch: throw an int and catch it.
int main() {
  try {
    throw 42;
  } catch (int e) {
    printInt(e);
  }
  return 0;
}
