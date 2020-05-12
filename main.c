void clear(){
	char *vidptr = (char*)0xb8000;
	unsigned int i = 0;
	unsigned int j = 0;

	while(j < 80 * 25 * 2){
		vidptr[j] = ' ';
		vidptr[j+1] = 0x07;
		j = j + 2;
	}
}

void showstring(char *message){
	char *vidptr = (char*)0xb8000;
	unsigned int i = 0;
	unsigned int j = 0;
	
	while(message[j] != '\0'){
		vidptr[i] = message[j];
		vidptr[i+1] = 0x07;
		++j;
		i = i + 2;
	}
}

void main(void){
	char *str = "Teoria de sistemas operativos\nIntegrantes:\n       Alejandro Rudolphy\n          Sebastian Gonzalez";
		clear();
		showstring(str);

	for(;;);
}
