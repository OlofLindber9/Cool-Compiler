// Simple test for shortcut boolean operations

bool ff () {
  printInt(0);
  return false;
}
bool tt () {
  printInt(1);
  return true;
}

int main () {
  let bool t = true;
  let bool f = false;
  let bool silent1 = f && ff();  // nothing
  let bool silent2 = t || ff();  // nothing
  let bool noisy1  = t && tt();  // 1
  let bool noisy2  = f || tt();  // 1
  return 0;
}
