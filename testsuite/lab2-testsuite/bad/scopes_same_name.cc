bool i_want_a_bool(int not_a_bool) {
  return true;
}

int main () {
  let int var = 1;

  {
    let bool var = i_want_a_bool(var);
  }

  return 0;
}
