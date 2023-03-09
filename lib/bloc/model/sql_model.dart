class SqlModel {
  final int? id;
  final String title;
  final String content;
  final String author;
  final TodoState state;
  final DateTime createAt;
  final DateTime startOn;
  final DateTime expireOn;
  final DateTime? completeAt;

  SqlModel(
      {this.id,
      required this.title,
      required this.content,
      required this.author,
      required this.state,
      required this.createAt,
      required this.startOn,
      required this.expireOn,
      this.completeAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'state': getTodoStateValue(state),
      'createAt': createAt.millisecondsSinceEpoch,
      'startOn': startOn.millisecondsSinceEpoch,
      'expireOn': expireOn.millisecondsSinceEpoch,
      'completeAt': completeAt?.millisecondsSinceEpoch
    };
  }

  factory SqlModel.fromMap(Map<String, dynamic> json) => SqlModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        author: json['author'],
        state: getTodoStateByValue(json['state']),
        createAt: DateTime.fromMillisecondsSinceEpoch(json['createAt']),
        startOn: DateTime.fromMillisecondsSinceEpoch(json['startOn']),
        expireOn: DateTime.fromMillisecondsSinceEpoch(json['expireOn']),
        completeAt: json['completeAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['completeAt'])
            : null,
      );
}

enum TodoState { scheduled, inProgress, complete, expired }

int getTodoStateValue(TodoState state) {
  switch (state) {
    case TodoState.scheduled:
      return 0;
    case TodoState.inProgress:
      return 1;
    case TodoState.complete:
      return 2;
    case TodoState.expired:
      return 3;
    default:
      return 0;
  }
}

TodoState getTodoStateByValue(int stateValue) {
  switch (stateValue) {
    case 0:
      return TodoState.scheduled;
    case 1:
      return TodoState.inProgress;
    case 2:
      return TodoState.complete;
    case 3:
      return TodoState.expired;
    default:
      return TodoState.scheduled;
  }
}
