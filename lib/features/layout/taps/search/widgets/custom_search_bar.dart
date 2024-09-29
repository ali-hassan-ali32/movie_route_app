import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../manager/bloc/search_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    SearchCubit searchCubit = SearchCubit.get(context);

    return Padding(
      padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
      child: TextField(
        controller: searchCubit.searchController,
        onChanged: (value) {
          searchCubit.searchQuery = value;
          if(value.isNotEmpty) {
            searchCubit.getSearchList(searchQuery: value);
          }
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            fillColor: const Color(0xff514F4F),
            filled: true,
            hintText: 'search a movie',
            hintStyle: TextStyle(
              fontSize: 17.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w300,
            ),
            prefixIcon: Icon(Icons.search, size: 22.sp),
            suffixIcon: IconButton(
              onPressed: searchCubit.clearSearch,
              splashColor: Colors.transparent,
              icon: Icon(
                Icons.clear,
                size: 22.sp,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: Colors.grey, width: 1.5))),
      ),
    );
  }
}
