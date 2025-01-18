import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecoveryClubScreen extends StatefulWidget {
  const RecoveryClubScreen({super.key});

  @override
  State<RecoveryClubScreen> createState() => _RecoveryClubScreenState();
}

class _RecoveryClubScreenState extends State<RecoveryClubScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JoinedClubsProvider(),
      child: MaterialApp(
        title: 'Recovery Club',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const ClubJoinPage(),
        routes: {
          '/': (context) => const ClubJoinPage(),
          '/back': (context) => const Placeholder(),
          '/joined_clubs': (context) => const JoinedClubsPage(),
        },
      ),
    );
  }
}

// State Management Class
class JoinedClubsProvider extends ChangeNotifier {
  final Set<String> _joinedClubs = {};

  Set<String> get joinedClubs => _joinedClubs;

  bool isClubJoined(String clubName) => _joinedClubs.contains(clubName);

  void joinClub(String clubName) {
    _joinedClubs.add(clubName);
    notifyListeners();
  }

  void leaveClub(String clubName) {
    _joinedClubs.remove(clubName);
    notifyListeners();
  }
}

// Club model class
class Club {
  final String name;
  final String members;
  final String imagePath;

  Club({
    required this.name,
    required this.members,
    required this.imagePath,
  });
}

// ClubJoinPage
class ClubJoinPage extends StatefulWidget {
  const ClubJoinPage({super.key});

  @override
  State<ClubJoinPage> createState() => _ClubJoinPageState();
}

class _ClubJoinPageState extends State<ClubJoinPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Club> allClubs = [
    Club(
      name: 'Alcoholics Anonymous',
      members: '11.0M members',
      imagePath: 'assets/club_images/aa_logo.jpg',
    ),
    Club(
      name: 'A new step to new life',
      members: '15.0M members',
      imagePath: 'assets/club_images/newstep_logo.jpg',
    ),
    Club(
      name: 'To be better',
      members: '13.0M members',
      imagePath: 'assets/club_images/better_logo.jpg',
    ),
    Club(
      name: 'Stand with you',
      members: '12.0M members',
      imagePath: 'assets/club_images/stand_logo.jpg',
    ),
  ];
  List<Club> displayedClubs = [];

  @override
  void initState() {
    super.initState();
    displayedClubs = List.from(allClubs);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      displayedClubs = allClubs
          .where((club) => club.name.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  Widget _buildClubTile(Club club, BuildContext context, JoinedClubsProvider provider) {
    bool isJoined = provider.isClubJoined(club.name);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F4F0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Image.asset(
          club.imagePath,
          width: 40,
          height: 40,
        ),
        title: Text(
          club.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(club.members),
        trailing: ElevatedButton(
          onPressed: () {
            if (isJoined) {
              provider.leaveClub(club.name);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Left ${club.name}')),
              );
            } else {
              provider.joinClub(club.name);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Joined ${club.name}')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isJoined ? Colors.grey : const Color(0xFF90EE90),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(isJoined ? 'Leave' : 'Join'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JoinedClubsProvider>(
      builder: (context, provider, child) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/club_images/background.jpg'),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Join the club that suits\nyour needs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayedClubs.length,
                      itemBuilder: (context, index) {
                        return _buildClubTile(
                          displayedClubs[index],
                          context,
                          provider,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// JoinedClubsPage
class JoinedClubsPage extends StatelessWidget {
  const JoinedClubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JoinedClubsProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Your Joined Clubs'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: provider.joinedClubs.isEmpty
            ? const Center(
                child: Text('You haven\'t joined any clubs yet'),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.joinedClubs.length,
                itemBuilder: (context, index) {
                  String clubName = provider.joinedClubs.elementAt(index);
                  return ListTile(
                    title: Text(clubName),
                  );
                },
              ),
      ),
    );
  }
}
