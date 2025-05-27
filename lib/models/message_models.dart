class Message {
  final String sender;
  final String content;
  final bool isUser;
  final String timestamp;
  Message({
    required this.sender,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}

final List<Message> messages = [
  Message(
    sender: "Smithfield",
    content: "Hi Michelle, thanks for your interest in our product MacBook Air 2020 which is currently priced at ₦900,000.00.",
    isUser: false,
    timestamp: "2023-05-02 || 02:04 pm",
  ),
  Message(
    sender: "Smithfield",
    content: "We appreciate your offer of ₦600,000. Our counteroffer is ₦805,000.00.",
    isUser: false,
    timestamp: "2023-05-02 || 02:04 pm",
  ),
  Message(
    sender: "You",
    content: "I am willing to pay ₦650,000.00.",
    isUser: true,
    timestamp: "2023-05-02 || 02:04 pm",
  ),
  Message(
    sender: "Smithfield",
    content: "We appreciate your offer of ₦650,000. Our counteroffer is ₦705,000.00.",
    isUser: false,
    timestamp: "2023-05-02 || 02:04 pm",
  ),
];