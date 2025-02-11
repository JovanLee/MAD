import 'package:flutter/material.dart';

Map<String, String> tempUserData = {};
String? loggedInUser;

void main() {
  runApp(MyApp());
}

// MAIN FILE
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

// MAIN SCREEN
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    PlanPage(),
    AboutPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}

// LOGIN PAGE
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String username = usernameController.text.trim();
                  String password = passwordController.text.trim();
                  if (tempUserData.containsKey(username)) {
                    List<String> data = tempUserData[username]!.split('|');
                    if (data.length == 2 && data[1] == password) {
                      loggedInUser = username;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                      return;
                    }
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid username or password')),
                  );
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Don’t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// REGISTER PAGE
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Register', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String username = usernameController.text.trim();
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();
                  if (username.isEmpty || email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('All fields are required')),
                    );
                    return;
                  }
                  if (tempUserData.containsKey(username)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Username already taken')),
                    );
                    return;
                  }
                  tempUserData[username] = "$email|$password";
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registration successful! Please log in.')),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HOME PAGE
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(); 
}
class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> restaurants = [
    {
      "name": "McDonald's",
      "location": "Burger Blvd",
      "hours": "9 AM - 10 PM",
      "image": "mcdonalds",
      "menu": [
        {
          "name": "Big Mac",
          "description": "Classic Big Mac with two beef patties and special sauce.",
          "price": "\$5.99",
          "tags": ["Beef"],
          "image": "bigmac"
        },
        {
          "name": "McChicken",
          "description": "Chicken sandwich with mayo and lettuce.",
          "price": "\$4.49",
          "tags": ["Chicken"],
          "image": "mcchicken"
        },
        {
          "name": "Filet-O-Fish",
          "description": "Fish sandwich with tartar sauce.",
          "price": "\$4.99",
          "tags": ["Fish"],
          "image": "filetofish"
        },
      ],
    },
    {
      "name": "Burger King",
      "location": "Flame-Grill Street",
      "hours": "10 AM - 11 PM",
      "image": "burgerking",
      "menu": [
        {
          "name": "Whopper",
          "description": "Flame-grilled beef patty with fresh toppings.",
          "price": "\$5.49",
          "tags": ["Beef"],
          "image": "whopper"
        },
        {
          "name": "Chicken Fries",
          "description": "Crispy chicken fries with dipping sauce.",
          "price": "\$3.99",
          "tags": ["Chicken"],
          "image": "chickenfries"
        },
        {
          "name": "Impossible Whopper",
          "description": "Plant-based patty with classic Whopper fixings.",
          "price": "\$6.49",
          "tags": ["Vegetarian"],
          "image": "impossiblewhopper"
        },
      ],
    },
    {
      "name": "KFC",
      "location": "Chicken Lane",
      "hours": "11 AM - 12 AM",
      "image": "kfc",
      "menu": [
        {
          "name": "Original Recipe Chicken",
          "description": "Crispy fried chicken with secret herbs and spices.",
          "price": "\$6.99",
          "tags": ["Chicken"],
          "image": "originalrecipechicken"
        },
        {
          "name": "Zinger Burger",
          "description": "Spicy crispy chicken burger.",
          "price": "\$5.99",
          "tags": ["Spicy"],
          "image": "zingerburger"
        },
        {
          "name": "Popcorn Chicken",
          "description": "Bite-sized crispy chicken pieces.",
          "price": "\$4.49",
          "tags": ["Chicken"],
          "image": "popcornchicken"
        },
      ],
    },
    {
      "name": "Subway",
      "location": "Sandwich Circle",
      "hours": "9 AM - 9 PM",
      "image": "subway",
      "menu": [
        {
          "name": "Italian BMT",
          "description": "Sub with salami, pepperoni, and ham.",
          "price": "\$6.49",
          "tags": ["Meat"],
          "image": "italianbmt"
        },
        {
          "name": "Chicken Teriyaki",
          "description": "Sub with grilled chicken and teriyaki sauce.",
          "price": "\$6.29",
          "tags": ["Chicken"],
          "image": "chickenteriyaki"
        },
        {
          "name": "Veggie Delight",
          "description": "Fresh veggies on freshly baked bread.",
          "price": "\$5.99",
          "tags": ["Vegetarian"],
          "image": "veggiedelight"
        },
      ],
    },
    {
      "name": "Taco Bell",
      "location": "Taco Terrace",
      "hours": "10 AM - 12 AM",
      "image": "tacobell",
      "menu": [
        {
          "name": "Crunchwrap Supreme",
          "description": "A wrap filled with beef, cheese, lettuce, and tostada crunch.",
          "price": "\$4.99",
          "tags": ["Beef"],
          "image": "crunchwrapsupreme"
        },
        {
          "name": "Beef Chalupa Supreme",
          "description": "Chalupa with seasoned beef and crisp toppings.",
          "price": "\$5.49",
          "tags": ["Beef"],
          "image": "beefchalupasupreme"
        },
        {
          "name": "Doritos Locos Tacos",
          "description": "Taco with a Doritos-flavored shell and seasoned beef.",
          "price": "\$2.99",
          "tags": ["Beef"],
          "image": "doritoslocostacos"
        },
      ],
    },
    {
      "name": "Wendy's",
      "location": "Salad Street",
      "hours": "10 AM - 10 PM",
      "image": "wendys",
      "menu": [
        {
          "name": "Dave's Single",
          "description": "Juicy beef burger with fresh toppings.",
          "price": "\$5.29",
          "tags": ["Beef"],
          "image": "davessingle"
        },
        {
          "name": "Spicy Chicken Nuggets",
          "description": "Crispy and spicy chicken nuggets.",
          "price": "\$4.79",
          "tags": ["Spicy"],
          "image": "spicychickennuggets"
        },
        {
          "name": "Frosty",
          "description": "A classic frozen dairy dessert.",
          "price": "\$2.99",
          "tags": ["Dessert"],
          "image": "frosty"
        },
      ],
    },
    {
      "name": "Pizza Hut",
      "location": "Pizza Plaza",
      "hours": "10 AM - 11 PM",
      "image": "pizzahut",
      "menu": [
        {
          "name": "Pepperoni Pizza",
          "description": "Pizza loaded with pepperoni and cheese.",
          "price": "\$8.99",
          "tags": ["Meat"],
          "image": "pepperonipizza"
        },
        {
          "name": "Cheesy Bites Pizza",
          "description": "Pizza with extra cheese and cheesy bites.",
          "price": "\$7.99",
          "tags": ["Cheese"],
          "image": "cheesybitespizza"
        },
        {
          "name": "Garlic Breadsticks",
          "description": "Freshly baked breadsticks with garlic butter.",
          "price": "\$3.99",
          "tags": ["Side"],
          "image": "garlicbreadsticks"
        },
      ],
    },
    {
      "name": "Domino's Pizza",
      "location": "Pizza Parkway",
      "hours": "11 AM - 11 PM",
      "image": "dominos",
      "menu": [
        {
          "name": "Hand-Tossed Pepperoni Pizza",
          "description": "Classic hand-tossed pizza with pepperoni.",
          "price": "\$9.99",
          "tags": ["Meat"],
          "image": "handtossedpepperonipizza"
        },
        {
          "name": "Chicken Alfredo Pasta",
          "description": "Pasta in creamy alfredo sauce with chicken.",
          "price": "\$10.99",
          "tags": ["Chicken"],
          "image": "chickenalfredopasta"
        },
        {
          "name": "Cinnamon Bread Twists",
          "description": "Sweet bread twists with cinnamon sugar.",
          "price": "\$3.49",
          "tags": ["Dessert"],
          "image": "cinnamonbreadtwists"
        },
      ],
    },
  ];
  List<Map<String, dynamic>> popularItems = [
    {
      "name": "Big Mac",
      "description": "Classic Big Mac with two beef patties.",
      "price": "\$5.99",
      "tags": ["Beef"],
      "image": "bigmac"
    },
    {
      "name": "Whopper",
      "description": "Flame-grilled beef burger.",
      "price": "\$5.49",
      "tags": ["Beef"],
      "image": "whopper"
    },
    {
      "name": "Original Recipe Chicken",
      "description": "Crispy fried chicken.",
      "price": "\$6.99",
      "tags": ["Chicken"],
      "image": "originalrecipechicken"
    },
    {
      "name": "Italian BMT",
      "description": "Sub with salami, pepperoni and ham.",
      "price": "\$6.49",
      "tags": ["Meat"],
      "image": "italianbmt"
    },
    {
      "name": "Crunchwrap Supreme",
      "description": "A wrap with beef and cheese.",
      "price": "\$4.99",
      "tags": ["Beef"],
      "image": "crunchwrapsupreme"
    },
    {
      "name": "Dave's Single",
      "description": "Juicy beef burger.",
      "price": "\$5.29",
      "tags": ["Beef"],
      "image": "davessingle"
    },
  ];
  List<Map<String, dynamic>> filteredRestaurants = [];
  bool isSearching = false;
  void _searchRestaurants(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      filteredRestaurants = restaurants.where((restaurant) => restaurant["name"].toLowerCase().contains(query.toLowerCase())).toList();
    });
  }
  @override
  void initState() {
    super.initState();
    filteredRestaurants = restaurants;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: _searchRestaurants,
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: isSearching
          ? _buildSearchResults()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Popular Restaurants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = restaurants[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RestaurantDetailPage(restaurant: restaurant)),
                            );
                          },
                          child: Container(
                            width: 120,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("images/${restaurant["image"]}.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  restaurant["name"],
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Popular Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: 300,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: popularItems.length,
                      itemBuilder: (context, index) {
                        var item = popularItems[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FoodDetailPage(food: item)),
                            );
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/${item["image"]}.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                item["name"],
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: filteredRestaurants.length,
      itemBuilder: (context, index) {
        var restaurant = filteredRestaurants[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(restaurant["name"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${restaurant["location"]}'),
                Text('Open Hours: ${restaurant["hours"]}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestaurantDetailPage(restaurant: restaurant)),
              );
            },
          ),
        );
      },
    );
  }
}

// RESTAURANT DETAIL PAGE
class RestaurantDetailPage extends StatefulWidget {
  final Map<String, dynamic> restaurant;
  RestaurantDetailPage({required this.restaurant});
  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}
class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  List<Map<String, dynamic>> filteredMenu = [];
  String _selectedCategory = "All";
  late RangeValues _selectedPriceRange;
  double _minPrice = 0.0, _maxPrice = 0.0;
  List<String> _selectedTags = [];
  List<String> _allTags = [];
  @override
  void initState() {
    super.initState();
    filteredMenu = List<Map<String, dynamic>>.from(widget.restaurant["menu"]);
    List<double> prices = [];
    for (var item in widget.restaurant["menu"]) {
      double price = double.tryParse(item["price"].replaceAll("\$", "")) ?? 0.0;
      prices.add(price);
    }
    if (prices.isNotEmpty) {
      _minPrice = prices.reduce((a, b) => a < b ? a : b);
      _maxPrice = prices.reduce((a, b) => a > b ? a : b);
    }
    _selectedPriceRange = RangeValues(_minPrice, _maxPrice);
    Set<String> tagSet = {};
    for (var item in widget.restaurant["menu"]) {
      if (item["tags"] != null) {
        for (var tag in item["tags"]) {
          tagSet.add(tag);
        }
      }
    }
    _allTags = tagSet.toList();
  }
  void _filterMenuItems() {
    List<Map<String, dynamic>> tempFiltered = [];
    for (var item in widget.restaurant["menu"]) {
      String itemCategory = item.containsKey("category") ? item["category"] : "Lunch";
      if (_selectedCategory != "All" && itemCategory != _selectedCategory) {
        continue;
      }
      double itemPrice = double.tryParse(item["price"].replaceAll("\$", "")) ?? 0.0;
      if (itemPrice < _selectedPriceRange.start || itemPrice > _selectedPriceRange.end) {
        continue;
      }
      if (_selectedTags.isNotEmpty) {
        bool hasTag = _selectedTags.any((tag) => (item["tags"] as List<dynamic>).contains(tag));
        if (!hasTag) {
          continue;
        }
      }
      tempFiltered.add(item);
    }
    setState(() {
      filteredMenu = tempFiltered;
    });
  }
  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Filter Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      Text("Category"),
                      DropdownButton<String>(
                        value: _selectedCategory,
                        items: ["All", "Breakfast", "Lunch", "Dinner"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setModalState(() {
                            _selectedCategory = newVal!;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      Text("Price Range (\$${_selectedPriceRange.start.toStringAsFixed(2)} - \$${_selectedPriceRange.end.toStringAsFixed(2)})"),
                      RangeSlider(
                        values: _selectedPriceRange,
                        min: _minPrice,
                        max: _maxPrice,
                        divisions: (_maxPrice - _minPrice).ceil(),
                        labels: RangeLabels("\$${_selectedPriceRange.start.toStringAsFixed(2)}", "\$${_selectedPriceRange.end.toStringAsFixed(2)}"),
                        onChanged: (RangeValues values) {
                          setModalState(() {
                            _selectedPriceRange = values;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      Text("Dietary Needs / Tags"),
                      Wrap(
                        spacing: 8,
                        children: _allTags.map((tag) {
                          bool isSelected = _selectedTags.contains(tag);
                          return FilterChip(
                            label: Text(tag),
                            selected: isSelected,
                            onSelected: (selected) {
                              setModalState(() {
                                if (selected) {
                                  _selectedTags.add(tag);
                                } else {
                                  _selectedTags.remove(tag);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              setModalState(() {
                                _selectedCategory = "All";
                                _selectedPriceRange = RangeValues(_minPrice, _maxPrice);
                                _selectedTags.clear();
                              });
                            },
                            child: Text("Reset"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _filterMenuItems();
                              Navigator.pop(context);
                            },
                            child: Text("Apply Filters"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant["name"]),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/${widget.restaurant["image"]}.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${widget.restaurant["location"]}'),
                Text('Open Hours: ${widget.restaurant["hours"]}'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMenu.length,
              itemBuilder: (context, index) {
                var item = filteredMenu[index];
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/${item["image"]}.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(item["name"]),
                    subtitle: Text(item["description"]),
                    trailing: Text(item["price"]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodDetailPage(food: item)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// FOOD DETAIL PAGE
class FoodDetailPage extends StatelessWidget {
  final Map<String, dynamic> food;
  FoodDetailPage({required this.food});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food["name"])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/${food["image"]}.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food["name"], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Price: ${food["price"]}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  Text(food["description"], style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: (food["tags"] as List<dynamic>).map<Widget>((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(tag, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PROFILE PAGE (UPDATED: updates email and password)
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    String currentEmail = "N/A";
    String currentPassword = "";
    if (loggedInUser != null && tempUserData.containsKey(loggedInUser)) {
      List<String> data = tempUserData[loggedInUser]!.split('|');
      if (data.isNotEmpty) {
        currentEmail = data[0];
        if (data.length > 1) {
          currentPassword = data[1];
        }
      }
    }
    emailController.text = currentEmail;
    passwordController.text = currentPassword;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
              SizedBox(height: 20),
              Text("Username: ${loggedInUser ?? "N/A"}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        String newEmail = emailController.text.trim();
                        String newPassword = passwordController.text.trim();
                        if (newEmail.isEmpty || newPassword.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fields cannot be empty")));
                          return;
                        }
                        String currentUsername = loggedInUser!;
                        tempUserData[currentUsername] = "$newEmail|$newPassword";
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile updated")));
                        setState(() {});
                      },
                      child: Text("Save")),
                  ElevatedButton(
                      onPressed: () {
                        loggedInUser = null;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                        );
                      },
                      child: Text("Logout"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// PLAN PAGE
class PlanPage extends StatefulWidget {
  @override
  _PlanPageState createState() => _PlanPageState();
}
class _PlanPageState extends State<PlanPage> {
  List<Map<String, dynamic>> mealPlans = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meal Plan")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              var selectedRecipe = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeListPage()),
              );
              if (selectedRecipe != null) {
                setState(() {
                  mealPlans.add(selectedRecipe);
                });
              }
            },
            child: Text("Add Plan"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mealPlans.length,
              itemBuilder: (context, index) {
                var recipe = mealPlans[index];
                return ListTile(
                  title: Text(recipe["name"]),
                  subtitle: Text("Items: ${recipe["items"].join(', ')}\nSteps: ${recipe["steps"]}\nDate: ${recipe["date"]}, Time: ${recipe["time"]}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// RECIPE LIST PAGE
class RecipeListPage extends StatelessWidget {
  final List<Map<String, dynamic>> recipes = [
    {
      "name": "Chicken Biryani",
      "items": ["Chicken", "Rice", "Spices", "Onion", "Yogurt"],
      "steps": "Marinate chicken; Fry onions; Cook rice; Combine and cook together.",
      "tags": ["Halal"],
      "image": "chickenbiryani"
    },
    {
      "name": "Vegan Salad",
      "items": ["Lettuce", "Tomato", "Cucumber", "Olives", "Avocado"],
      "steps": "Chop vegetables; Toss with dressing.",
      "tags": ["Vegan"],
      "image": "vegansalad"
    },
    {
      "name": "Pasta Primavera",
      "items": ["Pasta", "Vegetables", "Olive Oil", "Garlic", "Basil"],
      "steps": "Cook pasta; Sauté vegetables; Mix together.",
      "tags": ["Vegetarian"],
      "image": "pastaprimavera"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select a Recipe")),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          var recipe = recipes[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/${recipe["image"]}.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(recipe["name"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text("Tags: ${recipe["tags"].join(', ')}"),
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe)),
                );
                if (result != null) {
                  Navigator.pop(context, result);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

// RECIPE DETAIL PAGE
class RecipeDetailPage extends StatefulWidget {
  final Map<String, dynamic> recipe;
  RecipeDetailPage({required this.recipe});
  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}
class _RecipeDetailPageState extends State<RecipeDetailPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100)
    );
    if (picked != null) {
      setState(() {
        dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }
  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeController.text = picked.format(context);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var recipe = widget.recipe;
    return Scaffold(
      appBar: AppBar(title: Text(recipe["name"])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/${recipe["image"]}.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe["name"], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Items: ${recipe["items"].join(', ')}", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text("Steps: ${recipe["steps"]}", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: (recipe["tags"] as List<dynamic>).map<Widget>((tag) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 4),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(tag, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: "Date",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: _selectDate,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      labelText: "Time",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: _selectTime,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (dateController.text.isEmpty || timeController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select date and time")));
                          return;
                        }
                        recipe["date"] = dateController.text;
                        recipe["time"] = timeController.text;
                        Navigator.pop(context, recipe);
                      },
                      child: Text("Add to Plan"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ABOUT PAGE
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 40, child: Text('FH')),
              SizedBox(height: 20),
              Text('Application Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Food Helper', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Company Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Know Your Food', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Contact Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('12345678', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('knowyourfood@something', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
