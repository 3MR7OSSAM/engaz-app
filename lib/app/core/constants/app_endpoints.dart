abstract class EndpointConstants {
  // Base URL
  static const String baseUrl = 'https://engaz_taskjo.online/api';
  // static const String baseUrl = 'http://amengaz_tasks.com/api';

  //-------------------------------------------
  static const String getAllData = '/press/auth/getAllData';
  //-------------------------------------------
  // Authentication Routes
  static const String signUp = '/press/auth/registerApi';
  static const String login = '/press/auth/loginApi';
  static const String logout = '/logout';
  static const String profile = '/press/auth/press-profile';
  static const String forgetPassword = '/press/auth/forgetPassword';
  static const String verificationCode = '/press/auth/reset';
  static const String updatePassword = '/press/auth/confirm';
  static const String getCountries = '/press/countries';

  //-------------------------------------------
  // Clients Routes
  static const String getClients = '/press/clients';
  static const String addClient = '/press/clients/store';
  static const String updateClient = '/press/clients/update';
  static const String deleteClient = '/press/clients/delete';

  //-------------------------------------------
  // Reservations Routes
  static const String getReservations = '/press/reservations';
  static const String addReservation = '/press/reservations/store';
  static const String updateReservation = '/press/reservations/update';
  static const String deleteReservation = '/press/reservations/delete';

  //-------------------------------------------
  // Farms Routes
  static const String getFarms = '/press/farms';
  static const String addFarm = '/press/farms/store';
  static const String updateFarm = '/press/farms/update';
  static const String deleteFarm = '/press/farms/delete';

  //-------------------------------------------
  // Farms Routes
  static const String getPresents = '/press/presents';
  static const String addPresent = '/press/presents/store';

  //-------------------------------------------
  // Merchants Routes
  static const String getServiceOfficers = '/press/serviceOfficers';
  static const String getMerchants = '/press/merchants';
  static const String addMerchant = '/press/merchants/store';

  //-------------------------------------------
  // Merchants Routes
  static const String getSuppliers = '/press/suppliers';
  static const String addSupplier = '/press/suppliers/store';

  //-------------------------------------------
  // BuyOils Routes
  static const String getBuyOils = '/press/buyOils';
  static const String addBuyOil = '/press/buyOils/store';

  //-------------------------------------------
  // BuyOils Routes
  static const String getBuyOlives = '/press/buyOlives';
  static const String addBuyOlive = '/press/buyOlives/store';

  //-------------------------------------------
  // BuyOils Routes
  static const String getSalesOils = '/press/sellingOils';
  static const String addSaleOil = '/press/sellingOils/store';

  //-------------------------------------------
  // SaleOlives Routes
  static const String getSaleOlives = '/press/sellingOlives';
  static const String addSaleOlive = '/press/sellingOlives/store';

  //-------------------------------------------
  // Gift Routes
  static const String getGifts = '/press/gifts';
  static const String addGift = '/press/gifts/store';

  //-------------------------------------------
  // Gift Routes
  static const String getGiftExpenses = '/press/secExpenses';
  static const String addGiftExpense = '/press/secExpenses/store';

  //-------------------------------------------
  // Stuffs Routes
  static const String getStuffs = '/press/employees';
  static const String addStuff = '/press/employees/store';

  //-------------------------------------------
  // Salaries Routes
  static const String getSalaries = '/press/salaries';
  static const String addSalary = '/press/salaries/store';

  //-------------------------------------------
  // VehicleExpenses Routes
  static const String getVehicleExpenses = '/press/vehicleExpenses';
  static const String addVehicleExpense = '/press/vehicleExpenses/store';

  //-------------------------------------------
  // Receipts Routes
  static const String getCashReceipts = '/press/cashReceipts';
  static const String addCashReceipt = '/press/cashReceipts/store';

  //-------------------------------------------
  // Receipts Routes
  static const String getReceipts = '/press/disbursementVouchers';
  static const String addReceipt = '/press/disbursementVouchers/store';

  //-------------------------------------------
  // VehicleExpenses Routes
  static const String getExpenseTypes = '/press/expensesTypes';
  static const String getExpenses = '/press/expenses';
  static const String addExpense = '/press/expenses/store';
  static const String testPost = '/api/post';

  //-------------------------------------------
  // Orders Routes
  static const String getLines = '/press/fonts';
  static const String getOrders = '/press/reservations/search';
  static const String createOrder = '/press/reservations/store';
  static const String getMeals = '/press/meals';
  static const String createMeal = '/press/meals/store';
  static const String updateMeal = '/press/meals/update';
  static const String deleteMeal = '/press/meals/delete';

  static const String addStateOlivePressing = '/press/reservations/statusStore';
  static const String addCustomerAccounting = '/press/accountings/store';
  static const String getTankTypes = '/press/items';
  static const String getPressOperation = '/press/reservations/statusShowAll';

  ////-------------------------------------------
}
