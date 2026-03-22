int main() {
	let int x ;
	x = 6 ;
	let int y ;
	y = x + 7 ;
	printInt(y);
	{
		let int y ;
		y = 4 ;
		printInt(y);
		x = y ;
		printInt(x);
	}
	printInt(x);
	printInt(y);

	return 0;
}
