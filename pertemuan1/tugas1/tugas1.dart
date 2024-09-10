void main() {
  //input suhu dalam celcius (hardcoded for DartPad)
  double suhuCelcius = 25; // Masukan suhu di sini

  //konversi suhu celcius ke fahrenheit
  double suhuFahrenheit = (suhuCelcius * 9 / 5) + 32;

  //konversi suhu celcius ke kelvin
  double suhuKelvin = suhuCelcius + 273.15;

  //output hasil konversi
  print('Hasil konversi suhu dari celcius ke fahrenheit: $suhuFahrenheit');
  print('Hasil konversi suhu dari celcius ke kelvin: $suhuKelvin');
}
