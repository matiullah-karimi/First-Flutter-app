import 'package:flutter/material.dart';
import 'package:hello_world/helpers/server_configs.dart';
import 'package:hello_world/model/landing_page.dart';

class LandingPages extends StatelessWidget {
  Widget _linesListView() {
    return FutureBuilder<List<LandingPage>>(
        future: LandingPage.list(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.fromSize(
                  size: const Size.fromHeight(100.0),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(top: 8.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                            ServerConfigs.serverUrl + "/storage/" + snapshot.data[index].image,
                            width: 180.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return _linesListView();
  }
}
