class CardModel {
  String doctor;
  String image;


  CardModel(this.doctor, this.image);
}

List<CardModel> cards = [
  CardModel("Fever treatment for children: a doctor's advice",
      'images/image-medical.jpg'),
  CardModel(
      'How is pneumonia treated?',
      'images/doctor-consulting-with-patient-vector.jpg'
      ),
  CardModel('Could it be gallstones?', 'images/three.jpg'),

];
