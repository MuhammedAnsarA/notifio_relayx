import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:notifio_relayx/provider/service_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    Key? key,
    required this.getIndex,
  }) : super(key: key);
  final int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
      data: (todoData) {
        Color categoryColor = Colors.white;
        final getCategory = todoData[getIndex].category;
        switch (getCategory) {
          case "Learning":
            categoryColor = Colors.green;
            break;
          case "Working":
            categoryColor = Colors.blue.shade700;
            break;
          case "General":
            categoryColor = Colors.amber.shade700;
            break;
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: todoData[getIndex].isDone
                            ? IconButton(
                                onPressed: () => ref
                                    .read(serviceProvider)
                                    .deleteTask(todoData[getIndex].docId),
                                icon: const Icon(Ionicons.trash),
                              )
                            : null,
                        title: Text(
                          todoData[getIndex].titleTask,
                          maxLines: 1,
                          style: TextStyle(
                            decoration: todoData[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          todoData[getIndex].description,
                          maxLines: 1,
                          style: TextStyle(
                            decoration: todoData[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            activeColor: Colors.blue.shade800,
                            shape: const CircleBorder(),
                            value: todoData[getIndex].isDone,
                            onChanged: (value) =>
                                ref.read(serviceProvider).updateTask(
                                      todoData[getIndex].docId,
                                      value,
                                    ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Container(
                          child: Column(children: [
                            Divider(
                              thickness: 1.5,
                              color: Colors.grey.shade200,
                            ),
                            Row(
                              children: [
                                Text(todoData[getIndex].dateTask),
                                const Gap(12),
                                Text(todoData[getIndex].timeTask),
                              ],
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => const Center(
        child: Text("Error"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
