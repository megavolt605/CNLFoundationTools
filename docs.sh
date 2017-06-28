JAZZY=$(which jazzy)
if [ $? != 0 ]; then
    echo -e "Jazzy is required to generate documentation. Install it with:\n"
    echo -e "    gem install jazzy\n"
    exit
fi

jazzy -x -project,CNLFoundationTools.xcodeproj,-scheme,CNLFoundationTools -a Complex\ Numbers -o ./Docs --sdk iphoneos --documentation=./*.md --github_url https://github.com/megavolt605/CNLFoundationTools --theme fullwidth

#git -C ../Docs/Model add .
#git -C ../Docs/Model commit -m "Updated `date`"
#git -C ../Docs/Model push