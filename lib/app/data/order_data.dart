class OrderData {
  String OrderNumber;
  String OrderDate;
  String OrderDescription;
  OrderStatus orderStatus;
  String CarBrand;
  String CarType;
  String CarModel;
  String CarStructureNumber;

  OrderData(
      {this.OrderNumber,
      this.OrderDate,
      this.OrderDescription,
      this.orderStatus,
      this.CarBrand,
      this.CarType,
      this.CarModel,
      this.CarStructureNumber});
}

enum OrderStatus {
  Dealerwaiting,
  DealerOffer,
  Deliverywaiting,
  DeliveryOffer,
  OrderDelivery,
  OrderDone
}

List<OrderData> OrderList = [
  new OrderData(
      OrderNumber: '100',
      OrderDate: '1-1-2020',
      OrderDescription: 'مطلوب قماش فرامل امامي يمين',
      orderStatus: OrderStatus.Dealerwaiting,
      CarBrand: 'سيارة تويوتا',
      CarModel: '2020',
      CarType: 'كامري',
      CarStructureNumber: '521454512101'),
  new OrderData(
      OrderNumber: '100',
      OrderDate: '1-1-2020',
      OrderDescription: 'مطلوب قماش فرامل امامي يمين',
      orderStatus: OrderStatus.DealerOffer,
      CarBrand: 'سيارة تويوتا',
      CarModel: '2020',
      CarType: 'كامري',
      CarStructureNumber: '521454512101'),
  new OrderData(
      OrderNumber: '100',
      OrderDate: '1-1-2020',
      OrderDescription: 'مطلوب قماش فرامل امامي يمين',
      orderStatus: OrderStatus.Deliverywaiting,
      CarBrand: 'سيارة تويوتا',
      CarModel: '2020',
      CarType: 'كامري',
      CarStructureNumber: '521454512101'),
  new OrderData(
      OrderNumber: '100',
      OrderDate: '1-1-2020',
      OrderDescription: 'مطلوب قماش فرامل امامي يمين',
      orderStatus: OrderStatus.DeliveryOffer,
      CarBrand: 'سيارة تويوتا',
      CarModel: '2020',
      CarType: 'كامري',
      CarStructureNumber: '521454512101'),
  new OrderData(
      OrderNumber: '100',
      OrderDate: '1-1-2020',
      OrderDescription: 'مطلوب قماش فرامل امامي يمين',
      orderStatus: OrderStatus.OrderDelivery,
      CarBrand: 'سيارة تويوتا',
      CarModel: '2020',
      CarType: 'كامري',
      CarStructureNumber: '521454512101'),
  new OrderData(
      OrderNumber: '100',
      OrderDate: '1-1-2020',
      OrderDescription: 'مطلوب قماش فرامل امامي يمين',
      orderStatus: OrderStatus.OrderDone,
      CarBrand: 'سيارة تويوتا',
      CarModel: '2020',
      CarType: 'كامري',
      CarStructureNumber: '521454512101')
];
