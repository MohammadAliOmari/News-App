import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class Search extends StatelessWidget {
  Search({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        List list = cubit.search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    onSubmitted: (value) {
                      cubit.getSearch(value);
                    },
                    // onTap: () {},
                    // onChanged: (String value) {
                    //   cubit.getSearch(value);
                    // },
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      labelText: 'Search',
                      labelStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )),
              Expanded(child: articleBuilder(list, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
