
import 'package:budgettrack/common/api_service.dart';
import 'package:budgettrack/model/transaction_model.dart';

class TransactionService
{
  Future<String?> saveIncome(TransactionModel transactionModel) async
  {
    print("Transaction Service Started");
    ApiService apiService = ApiService();
    try{
      print(transactionModel.toString());
      final saveIncomeResponse= await apiService.post("saveincometransaction",transactionModel.toJson());

      if(saveIncomeResponse != null  && saveIncomeResponse.containsKey('data')
          &&saveIncomeResponse['data'].containsKey('resultStatus')) {
        print("TransactionService Class : saveIncomeResponse : Success: $saveIncomeResponse");
        return saveIncomeResponse['data']['resultStatus'];
      }
      else
        {
          print("TransactionService Class : saveIncomeResponse : Failed: $saveIncomeResponse");
        }

    }
    catch(e)
    {
      print("TransactionService Class : saveIncome Method : Exception : $e");
    }
  }


  Future<String?> saveExpense(TransactionModel transactionModel) async
  {
    print("Transaction Service Started");
    ApiService apiService = ApiService();
    try{
      print(transactionModel.toString());
      final saveIncomeResponse= await apiService.post("saveexpensetransaction",transactionModel.toJson());

      if(saveIncomeResponse != null  && saveIncomeResponse.containsKey('data')
          &&saveIncomeResponse['data'].containsKey('resultStatus')) {
        print("TransactionService Class : saveIncomeResponse : Success: $saveIncomeResponse");
        return saveIncomeResponse['data']['resultStatus'];
      }
      else
      {
        print("TransactionService Class : saveIncomeResponse : Failed: $saveIncomeResponse");
      }

    }
    catch(e)
    {
      print("TransactionService Class : saveIncome Method : Exception : $e");
    }



  }

}