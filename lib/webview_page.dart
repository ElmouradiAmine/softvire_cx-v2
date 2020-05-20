
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  int _selectedIndex = 0;
  bool loading = false;
  WebViewController _controller;
  var urlList = [
    "https://www.softvire.com.au/?s=&product_cat=0&post_type=product",
    "https://softvireaus.force.com/s/"
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    print(_selectedIndex);
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
        _controller.loadUrl(urlList[index]);


      });
    }

    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              title: Text('Cart'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('SOFTVIRE'),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.home),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_basket),
            ),
          ],
        ),
        body:  Stack(
          children: <Widget>[
            WebView(
    
              initialUrl: urlList[_selectedIndex],
              
              onPageStarted: (url) {
                print('page started loading');
                setState(() {
                  loading = true;
                });
              },
              onPageFinished: (url) {
                print('page finished loading');
                setState(() {
                  loading = false;
                });
              },
              onWebResourceError: (url) {
                print('page finished with error');
                setState(() {
                  loading = false;
                });
              },
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                setState(() {
                  loading = false;
                });
              },
            ),
            
            Visibility(
              visible: loading,
                          child: Container(
                color: Colors.white,
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),

          ],
        ));
  }
}
