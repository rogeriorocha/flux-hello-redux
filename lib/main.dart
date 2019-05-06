import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = new Store<AppState>(reducerInc, initialState: new AppState(0));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redux Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(
        title: 'teste',
        store: store,
      ),
    );
  }
}

@immutable
class AppState {
  final total;

  AppState(this.total);
    
  
}

enum Actions { Increment, Decrement, Initial }

// function
AppState reducerInc(AppState prev, action) {
  if (action == Actions.Increment) {
    return new AppState(prev.total + 1);
  } else {
    if (action == Actions.Decrement) {
      return new AppState(prev.total - 1);
    }
  }

  return prev;
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.store, this.title}) : super(key: key);

  final Store<AppState> store;
  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Flux Redux"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'X vezes :',
                ),
                new StoreConnector<AppState, String>(
                  converter: (store) => store.state.total.toString(),
                  builder: (context, total) => new Text(
                        total,
                        style: Theme.of(context).textTheme.display1,
                      ),
                )
              ],
            ),
          ),
          floatingActionButton: Column(
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                new StoreConnector<AppState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(Actions.Increment);
                  },
                  builder: (context, callback) => new FloatingActionButton(
                        onPressed: callback,
                        tooltip: 'incremente',
                        child: new Icon(Icons.add),
                      ),
                ),
                new StoreConnector<AppState, VoidCallback>(
                  converter: (store) {
                    return () => store.dispatch(Actions.Decrement);
                  },
                  builder: (context, callback) => new FloatingActionButton(
                        onPressed: callback,
                        tooltip: 'decrement',
                        child: new Icon(Icons.remove),
                      ),
                ),
              ])),
    );
  }
}
