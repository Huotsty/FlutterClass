
class Joke {
  final String title;
  final String description;

  Joke({required this.title, required this.description});
}

List<Joke> generateJokes() {
  return List.generate(20, (index) {
    return Joke(
      title: "Joke Title ${index + 1}",
      description: "This is a funny joke description for joke ${index + 1}.",
    );
  });
}
