abstract class NavigationEvent{}

class NavigationOnChanged extends NavigationEvent{
  final int currentIndex;

  NavigationOnChanged(this.currentIndex);
}