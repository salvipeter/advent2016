#include <bitset>
#include <iostream>
#include <queue>
#include <vector>

// A-E: generators, a-e: microchips, X: elevator
//   EEDDCCBBAAeeddccbbaaXX
// 0b0000000000000000000000

// Part 1
// const int types = 5;
// const int init   = 0b0101010100101010100000;
// const int target = 0b1111111111111111111111;

// Part 2 (< 5s)
constexpr int types = 7;
constexpr int init   = 0b000001010101000000101010100000;
constexpr int target = 0b111111111111111111111111111111;

constexpr size_t size = 1 << (types * 2 + 1) * 2;
using Distances = std::vector<unsigned char>;

// Sets the i-th item in n to v (i = 0..10, v = 0..3)
// Returns a new state.
int set(int n, int i, int v) {
  if (v % 2 == 1)
    n |= 1 << i * 2;
  else
    n &= ~(1 << i * 2);
  if (v > 1)
    n |= 1 << (i * 2 + 1);
  else
    n &= ~(1 << (i * 2 + 1));
  return n;
}

// Queries the i-th item in n (i = 0..10)
char get(int n, int i) {
  bool c1 = n & (1 << i * 2);
  bool c2 = n & (1 << (i * 2 + 1));
  return (char)c2 * 2 + (char)c1;
}

// Checks that the state n is valid
bool check(int n) {
  for (int i = 1; i <= types; ++i) {
    int floor = get(n, i);
    if (floor != get(n, i + types))
      for (int j = 1; j <= types; ++j)
        if (floor == get(n, j + types))
          return false;
  }
  return true;
}

std::vector<int> nextStates(int state) {
  int floor = get(state, 0);
  std::vector<int> items;
  for (int i = 1; i <= types * 2; ++i)
    if (get(state, i) == floor)
      items.push_back(i);
  std::vector<int> result;
  for (size_t i = 0; i < items.size(); ++i) {
    int x = items[i];
    if (floor > 0) {
      int down = set(state, 0, floor - 1);
      int next = set(down, x, floor - 1);
      result.push_back(next);
      for (size_t j = i + 1; j < items.size(); ++j)
        result.push_back(set(next, items[j], floor - 1));
    }
    if (floor < 3) {
      int up = set(state, 0, floor + 1);
      int next = set(up, x, floor + 1);
      result.push_back(next);
      for (size_t j = i + 1; j < items.size(); ++j)
        result.push_back(set(next, items[j], floor + 1));
    }
  }
  return result;
}

void fillDistances(Distances &distances, int start) {
  std::queue<int> todo;
  todo.push(start);
  while (!todo.empty()) {
    int state = todo.front();
    todo.pop();
    for (int next : nextStates(state)) {
      if (check(next) && distances[next] > distances[state] + 1) {
        distances[next] = distances[state] + 1;
        todo.push(next);
      }
    }
  }
}

// For debug
void printState(int n) {
  std::cout << std::bitset<22>(n) << ":\n" << std::endl;
  for (int i = 3; i >= 0; --i) {
    if (get(n, 0) == i)
      std::cout << '*';
    else
      std::cout << ' ';
    std::cout << i + 1 << ' ';
    for (int j = 1; j <= types; ++j) {
      if (get(n, j + types) == i)
        std::cout << (char)('A' + j - 1);
      if (get(n, j) == i)
        std::cout << (char)('a' + j - 1);
    }
    std::cout << std::endl;
  }
  std::cout << "---" << std::endl;
}

void showSolution(const Distances &distances, int state) {
  while (distances[state] != 0) {
    printState(state);
    for (int next : nextStates(state))
      if (distances[next] == distances[state] - 1) {
        state = next;
        break;
      }
  }
  printState(state);
}

int main(int argc, char **argv) {
  Distances distances;
  distances.resize(size, 255);
  distances[init] = 0;
  fillDistances(distances, init);
  // showSolution(distances, target);
  std::cout << (int)distances[target] << std::endl;
  return 0;
}
