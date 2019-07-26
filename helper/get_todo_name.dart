class GetToDoName{
  getToDoName(int x){
    switch (x) {
      case 0:
        return 'Important but not urgent';
        break;
      case 1:
        return 'Important and urgent';
        break;
      case 2:
        return 'Not important and not urgent';
        break;
      case 3: 
        return 'Not important but urgent';
        break;
      case 4:
        return 'Default missing!';
        break;
      default:
        return 'No such name($x)! avaliable range is 0-3!';
        break;
    }
  }
}