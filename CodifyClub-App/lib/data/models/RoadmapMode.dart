class RoadMapModel {
  final String topic;
  final String description;
  final List<StepModel> steps;
  final List<TipModel> tipsAndTricks;

  RoadMapModel({
    required this.topic,
    required this.description,
    required this.steps,
    required this.tipsAndTricks,
  });

  // Factory method to create a RoadMapModel from JSON
  factory RoadMapModel.fromJson(Map<String, dynamic> json) {
    return RoadMapModel(
      topic: json['topic'] as String,
      description: json['description'] as String,
      steps: (json['steps'] as List)
          .map((stepJson) => StepModel.fromJson(stepJson))
          .toList(),
      tipsAndTricks: (json['tips_and_tricks'] as List)
          .map((tipJson) => TipModel.fromJson(tipJson))
          .toList(),
    );
  }

  // Override toString for detailed output
  @override
  String toString() {
    return 'Topic: $topic\nDescription: $description\nSteps:\n${steps.map((step) => step.toString()).join('\n')}\nTips and Tricks:\n${tipsAndTricks.map((tip) => tip.toString()).join('\n')}';
  }
}

class StepModel {
  final String step;
  final String description;
  final List<ResourceModel> resources;

  StepModel({
    required this.step,
    required this.description,
    required this.resources,
  });

  // Factory method to create a StepModel from JSON
  factory StepModel.fromJson(Map<String, dynamic> json) {
    return StepModel(
      step: json['step'] as String,
      description: json['description'] as String,
      resources: (json['resources'] as List)
          .map((resourceJson) => ResourceModel.fromJson(resourceJson))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Step: $step\nDescription: $description\nResources:\n${resources.map((resource) => resource.toString()).join('\n')}';
  }
}

class ResourceModel {
  final String name;
  final String link;
  final String timeEstimate;

  ResourceModel({
    required this.name,
    required this.link,
    required this.timeEstimate,
  });

  // Factory method to create a ResourceModel from JSON
  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      name: json['name'] as String,
      link: json['link'] as String,
      timeEstimate: json['time_estimate'] as String,
    );
  }

  @override
  String toString() {
    return 'Name: $name\nLink: $link\nTime Estimate: $timeEstimate';
  }
}

class TipModel {
  final String tip;
  final String description;

  TipModel({
    required this.tip,
    required this.description,
  });

  // Factory method to create a TipModel from JSON
  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      tip: json['tip'] as String,
      description: json['description'] as String,
    );
  }

  @override
  String toString() {
    return 'Tip: $tip\nDescription: $description';
  }
}
