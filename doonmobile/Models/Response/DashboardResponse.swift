struct DashboardResponse : Decodable{
    let incomingShipmentCount: Int
    let inventoryCount: Int
    let outgoingShipmentCount: Int
    let usersCount: Int
}
