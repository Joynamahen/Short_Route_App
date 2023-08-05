import '../data/LocationNode.dart';

class LocationGraph {
  late List<LocationNode> nodes;
  late Map<LocationNode, Map<LocationNode, double>> adjacencyMap;
  Map<LocationNode, LocationNode?> previousNodes = {};

  LocationGraph({required this.nodes, required this.adjacencyMap});

  LocationNode? getPreviousNode(LocationNode node) {
    return previousNodes[node];
  }

  Map<LocationNode, double> dijkstraShortestPath(LocationNode source) {
    // Initialize distances with infinity for all nodes
    Map<LocationNode, double> distances = {};
    for (var node in nodes) {
      distances[node] = double.infinity;
    }

    // The distance from the source node to itself is 0
    distances[source] = 0;

    // Initialize a set to keep track of visited nodes
    Set<LocationNode> visitedNodes = {};

    while (visitedNodes.length < nodes.length) {

      // Find the node with the minimum distance among the unvisited nodes
      LocationNode currentNode = _findMinimumDistanceNode(distances, visitedNodes);

      // Mark the current node as visited
      visitedNodes.add(currentNode);

      // Update distances of neighbors of the current node
      if (adjacencyMap[currentNode] != null) {
        for (var neighbor in adjacencyMap[currentNode]!.keys) {
          double distanceToNeighbor = distances[currentNode]! + adjacencyMap[currentNode]![neighbor]!;
          if (distanceToNeighbor < distances[neighbor]!) {
            distances[neighbor] = distanceToNeighbor;
          }
        }
      }
    }

    return distances;
  }

  LocationNode _findMinimumDistanceNode(Map<LocationNode, double> distances, Set<LocationNode> visitedNodes) {
    double minDistance = double.infinity;
    LocationNode? minDistanceNode;

    for (var node in nodes) {
      if (!visitedNodes.contains(node) && distances[node]! < minDistance) {
        minDistance = distances[node]!;
        minDistanceNode = node;
      }
    }

    return minDistanceNode!;
  }
}
