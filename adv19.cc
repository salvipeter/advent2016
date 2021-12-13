#include <algorithm>
#include <iostream>
#include <vector>

int main(int argc, char **argv) {
  size_t elves = 3014603;
  bool part2 = true;
  using Neighbors = std::pair<size_t, size_t>;
  std::vector<Neighbors> circle(elves);
  for (size_t i = 0; i < elves; ++i)
    circle[i] = { (i + elves - 1) % elves, (i + 1) % elves };
  size_t count = elves, next = 0;
  size_t loser = part2 ? elves / 2 : 1;
  while (count > 1) {
    circle[circle[loser].first].second = circle[loser].second;
    circle[circle[loser].second].first = circle[loser].first;
    count--;
    loser = circle[loser].second;
    if (!part2 || count % 2 == 0)
      loser = circle[loser].second;
    next = circle[next].second;
  }
  std::cout << next + 1 << std::endl;
  return 0;
}
