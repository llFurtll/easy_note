import 'package:compmanager/screen_widget.dart';
import 'package:flutter/material.dart';

import '../controller/home_controller.dart';

class AlterNameHomeViewWidget extends ScreenWidget<HomeController> {
  const AlterNameHomeViewWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: const Icon(Icons.drag_handle, color: Colors.grey, size: 40.0),
            ), 
            Container(
              margin: const EdgeInsets.only(bottom: 25.0),
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Form(
                key: controller.formKeyAlterName,
                child: TextFormField(
                  initialValue: controller.nameUser.value,
                  onSaved: (newValue) => controller.nameUser.value = newValue!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor escreva um nome";
                    }

                    return null;
                  },
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              height: 50.0,
              margin: const EdgeInsets.only(bottom: 25.0),
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: controller.saveName,
                child: const Text("Salvar")
              ),
            )
          ],
        )
      ),
    );
  }
}