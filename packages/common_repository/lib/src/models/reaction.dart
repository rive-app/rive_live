/// Available reactions to trigger.
enum Reaction {
  love('love'),
  joy('joy'),
  mindblown('Mindblown'),
  fire('Onfire'),
  tada('Tada');

  const Reaction(this.artboard);

  final String artboard;
}
