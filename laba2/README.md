Добавить в тело экрана виджет Column. В Column добавить несколько
виджетов Row и в каждый Row добавить несколько иконок. Каждому
Row добавить выравнивание по ширине.
![изображение](https://github.com/user-attachments/assets/5f612794-d51c-4b27-8b8f-2cc20318fce2)
##  ГЛавный экран
### class _MyHomePageState extends State<MyHomePage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Нечталенко Илья ИВТ-22'), 
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildIconRow([Icons.star, Icons.favorite, Icons.home]),
              _buildIconRow([Icons.android, Icons.apple, Icons.language]),
              _buildIconRow([Icons.cloud, Icons.sunny, Icons.ac_unit]),
            ],
          ),
        ),
      );
    }
