import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Note this is STATELESS. Therefore the final output is immutable. This may not be correct...
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // but id we print HERE, we see a different context:
    print(context.widget);
    return MaterialApp(
      title: 'UTip App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          const UTip(), // because we have not yet defined it (well, we deleted it...)
      // this becomes the entry widget to display - i.e. the UTip widget below. He notes tha `const` should be added, but it does not error if omitted?
    );
  }
}

// note 'stl' for autocomplete is NOT THE SAME as 'stateful' - we get 'Flutter stateful widget' (full boilerplate) for the first, and 'StateflWidget' (just the class) for the second...
// This is a GOTCHA!!
// update the `home:` - once the boilerplate is added  -property value in MyApp above:

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  // the stateful props and methods need to be CLASS MEMBERS! NOT local vars inside build! ARGH!!! FFS!!!

  int personCount = 0;

  void decrementCounter() {
    setState(() {
      // this is KEY to the ui view changes (as well as data changes)
      if (personCount > 0) personCount--; // = personCount - 1;
    });
  }

  void incrementCounter() {
    setState(() {
      personCount++; // = personCount - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // debug (context info):
    debugPrint(context.owner.toString());
    debugPrint(context.widget.toString()); // toString() needed
    print(context.widget);
    // return const Placeholder(); // note the Placeholder() return type
    // so replace with a Scaffold type:
    // return const Scaffold(

    // quick-fix extract local var, and abstract to the method used:
    // this return sthe 'nearest' theme in the widget hierarcy - i.e. the one from above
    var theme = Theme.of(context);

    // for section #6.11:
    // note the complaint if copyWith() is called without the null check:
    // 'quick fix' again...
    final style = theme.textTheme.titleMedium!.copyWith(
      // and embellish the style here:
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      // Hmm... On the course, he shows that a grey autocomplete suggestion code boilerplate
      // is shown. This DOES NOT HAPPEN on this version of VS Code/Dart...  The hover tooltip
      // DOES show us the properties that a Scaffold can accept though. So that sort of helps.
      // the red error that appears is because we are trying to add a non-const to a const
      // constructor. Hmmm.... Better instruction on when to use `const` is needed.
      appBar: AppBar(
        title: const Text("UTip"),
      ), // I did NOT get blue squigglies...
      // We also want a body - again a container for other stuff:
      body: Column(
        // se note above re `const` here - but that fucks up the declaration of Container as a const...
        // for a Column, this is top to bottom:
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment
            .stretch, // has a similar visual effect to the alignment: prop of the container velow. But accounts for ALL contents
        mainAxisSize: MainAxisSize.max, // the default

        children: [
          // Text("body"),
          Container(
            // style the Container: (from vid)
            decoration: BoxDecoration(
              // color: Colors.greenAccent,
              // use theme defined above instead...
              // color: Theme.of(context).colorScheme.surface, // hmm... nothing
              // color: Theme.of(
              //   context,
              // ).dialogTheme.backgroundColor, // still nothing. WTF?
              // color: Theme.of(
              //   context,
              //   // ).colorScheme.onPrimary, // still nothing. WTF?
              // ).colorScheme.inversePrimary, // still nothing. WTF?
              color: theme.colorScheme.inversePrimary,
              border: BoxBorder.all(color: Colors.black45),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),

            // this applies to the decoration property? WTF???
            margin: EdgeInsets.all(3),

            // color: Colors.greenAccent, // cant have this in two places!

            // give the box some dimensions
            // width: 200, //Color.fromARGB(0, 243, 111, 137),
            // height: 40,

            // or, padding:
            // This seems to force full width?
            padding: EdgeInsets.all(18),

            // align the Container contents:
            // alignment:
            //     AlignmentGeometry.center, // THIS seems to force full width...
            // this must be last
            child: Column(
              // if const added here, it implies childs are const too. Adding `const` to the childs generates an 'unnecessary const' warning
              children: [
                Text(
                  "Total per person:",
                  // style: theme.of(context).textTheme.titleMedium,
                  // style: theme.textTheme.titleMedium,
                  // for section #6.11:
                  style: style, // note this is the themed style declared above
                ), // parents CANNOT be const (they are in he vid... But he changes it.)
                Text(
                  "\$20.99", // this will be a $ var...
                  // style: Theme.of(context).textTheme.displayMedium,
                  // style: theme.textTheme.displayMedium,
                  // and for #6.11, further embellish the style
                  style: style.copyWith(
                    // and further styles can be added/updated(?) here:
                    // color: theme.colorScheme.onPrimary,  // you DO NOT need to override it again!
                    //but, we can override it further:
                    // color: theme.colorScheme.inverseSurface,
                    // and we can embellish te theme with a text size:
                    fontSize: theme
                        .textTheme
                        .displaySmall!
                        .fontSize, // add a null check to stop VS Code bitching.
                  ), // note we don't get the null warning here (because already checked at initial setup?)
                  // selectionColor: Theme.of(context).colorScheme.inverseSurface,
                ),
              ],
              // ONE child... So the Text is wrapped in another Column
            ),
          ),
          // #6.12
          // form here:
          // add a Container
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              // can specify dimensions
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // borderRadius: BorderRadius.all(Radius.circular(12)),
                // CARE with where the propeties are added!! Width is clearly a line property...
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),

              // to give the same margin as main title (he may change this...):
              // he actually uses a Padding widget, surrounding the ENTIRE Container. Is this best practice?
              // i.e. when to use a SURROUNDING Padding widget, or to set the MARGIN prop of the thing itself?
              // margin: EdgeInsets.all(3),

              // padding: EdgeInsets.all(3), // This is INSIDE the container
              // child: const Column(
              // note that we can also apply the const keyword to any static widgets below instead
              child: Column(
                children: [
                  // test
                  // Text("BOB!")
                  // first add the 'bill amount' TextField frame:
                  TextField(
                    // an input box...
                    decoration: const InputDecoration(
                      border:
                          OutlineInputBorder(), // This is a concrete InputBorder class
                      // prefix: Text("sausage"),
                      // he uses prefixIcon:
                      prefixIcon: Icon(Icons.attach_money), // the dollar sign
                      labelText: "Show me the money!!",
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal:
                          true, // this explicitly adds a standalone . button
                    ),
                    // note - he uses simply TextInputType.number:
                    // keyboardType: TextInputType.number

                    // the key to capturing this is an event handler:
                    // initial demo:
                    onChanged: (String value) {
                      // why String???
                      debugPrint(value);
                    },
                    // see https://stackoverflow.com/questions/68675718/how-can-i-catch-event-when-a-text-field-is-exiting-focus-on-blur-in-flutter
                    // THIS is the way to add a blur event because we don't necessarily want to trigger a handler on each change.

                    // he initially added a const modifier to the containing Column - but it can't be because it chnages...
                  ),

                  // section #6.13
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // huh? He talks about this (to `start`) but then removes it?//.spaceBetween also works (and dont need )

                    children: [
                      Text(
                        "Split bill by:",
                        style: theme.textTheme.titleMedium,
                      ),
                      // note nested Row()
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,  // not needed
                        // the inc/dec controls:
                        children: [
                          IconButton(
                            color: theme.colorScheme.primary,
                            //NOTE: If the handler is null, then the buttons become disabled. Therefore, add a dummy anon function:
                            // onPressed: null,
                            onPressed: decrementCounter,
                            // () => {
                            //   // personCount = personCount - 1,
                            //   // debugPrint("removing")
                            // },
                            icon: const Icon(Icons.remove),
                          ),
                          // counter
                          // note use of $ in string to coerce the int to a string
                          Text(
                            "$personCount",
                            style: theme.textTheme.titleMedium,
                          ),
                          IconButton(
                            color: theme.colorScheme.primary,
                            //NOTE: If the handler is null, then the buttons become disabled. Therefore, add a dummy anon function:
                            // onPressed: null,
                            // onPressed: () => personCount++,
                            onPressed: incrementCounter,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ], // TODO:
                  ),
                  Text("BOB!"),
                ],
              ), // so we can pass > 1 child widget into here
            ),
          ),
        ],
      ),
    );
    // the Scaffold allows a hierarchy of stuff (AppBar etc) to give us a
    // layout of our app:
  }
}
