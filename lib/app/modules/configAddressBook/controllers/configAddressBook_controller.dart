import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ConfigAddressBookController extends GetxController {
 final box = GetStorage();
 final addressBook= [].obs;


 final addressBookIndex = 0.obs;

 void setAddressBookInfo () =>{
  addressBook.value = box.read('addressBook'),
  addressBook.refresh(),
 };




 void setAddressBookIndex (data) => addressBookIndex.value=data;


 void addressBook_add (data) =>{
  if(box.read('addressBook')==null){
   box.write("addressBook", [data])
  }else{
//添加
   box.read('addressBook').add(data),
   box.write("addressBook",box.read('addressBook')),
  },
  setAddressBookInfo(),
 };

 void removeAddressBook(index){
  box.read('addressBook').removeAt(index);
  box.write("addressBook",box.read('addressBook'));
  setAddressBookInfo();
 }

 void setAddressBookName (index,name) =>{
  box.read('addressBook')[index]["name"] = name,
  box.write("addressBook",box.read('addressBook')),
  // addressBook[index]["name"] = name,
  // addressBook.refresh(),
  setAddressBookInfo()
 };

 void setAddressBookAddress (index,address) =>{
  box.read('addressBook')[index]["address"] = address,
  box.write("addressBook",box.read('addressBook')),
  setAddressBookInfo()
  // addressBook[index]["address"] = address,
  // addressBook.refresh(),
 };

 void setAddressBookOpenState (index,openState) =>{
  box.read('addressBook')[index]["openState"] = openState,
  box.write("addressBook",box.read('addressBook')),
  setAddressBookInfo()
  // addressBook[index]["openState"] = openState,
  // addressBook.refresh(),
 };

 void setAddressBookProxyPayUsageCount (index,proxyPayUsageCount) =>{
  box.read('addressBook')[index]["proxyPayUsageCount"] = proxyPayUsageCount,
  box.write("addressBook",box.read('addressBook')),
  setAddressBookInfo()
  // addressBook[index]["proxyPayUsageCount"] = proxyPayUsageCount,
  // addressBook.refresh(),
 };
 void setAddressBookProxyPayTotal (index,proxyPayTotal) =>{
  box.read('addressBook')[index]["proxyPayTotal"] = proxyPayTotal,
  box.write("addressBook",box.read('addressBook')),
  setAddressBookInfo()
  // addressBook[index]["proxyPayTotal"] = proxyPayTotal,
  // addressBook.refresh(),
 };
}
