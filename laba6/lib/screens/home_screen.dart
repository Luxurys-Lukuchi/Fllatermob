import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../cubit/nasa_cubit.dart';
import '../models/photo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('curiosity Photos (Sol 100)')),
      body: BlocBuilder<NasaCubit, NasaState>(
        builder: (context, state) {
          if (state is NasaLoading) {
            context.read<NasaCubit>().fetchData();
            return const Center(child: CircularProgressIndicator());
          } else if (state is NasaLoaded) {
            return _buildPhotoList(state.data.photos);
          } else if (state is NasaError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPhotoList(List<Photo> photos) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return Card(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: photo.imgSrc,
                placeholder: (context, url) => const CircularProgressIndicator(),
              ),
              ListTile(
                title: Text('Camera: ${photo.camera.fullName}'),
                subtitle: Text('Earth Date: ${photo.earthDate}'),
                trailing: Text('Rover: ${photo.rover.name}'),
              ),
            ],
          ),
        );
      },
    );
  }
}
