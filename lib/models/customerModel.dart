class CustomerModel {
  int Id;
  int userId;
  String userName;
  int warehouseId;
  int itemId;
  String itemName;
  int Qty;
  int salePrice;
  int taxAmt;
  int totalamount;
  String Unit;
  int driverId;
  String orderDate;
  String deliveryAddress;
  int Location;

  CustomerModel(
      {this.Id,
      this.userId,
      this.userName,
      this.warehouseId,
      this.itemId,
      this.itemName,
      this.Qty,
      this.salePrice,
      this.taxAmt,
      this.totalamount,
      this.Unit,
      this.driverId,
      this.orderDate,
      this.deliveryAddress,
      this.Location});

  factory CustomerModel.fromJson(final json) {
    return CustomerModel(
      Id: json["id"],
      userId: json["user_id"],
      userName: json["user_name"],
      warehouseId: json["warehouse_id"],
      itemId: json["item_id"],
      itemName: json["item_name"],
      Qty: json["qty"],
      salePrice: json["sale_price"],
      taxAmt: json["tax_amt"],
      totalamount: json["total_amount"],
      Unit: json["unit"],
      driverId: json["driver_id"],
      orderDate: json["order_date"],
      deliveryAddress: json["delivery_address"],
      Location: json["location"],
    );
  }
}
