# CherokeeLessons.com

The new and improved CherokeeLessons.com using the Zola static site generator.

![Screenshot](screenshot.png)

## Notes

postWeight=$(("$(date +%s)" / 10 * 10))
postDate="$(TZ=UTC date -u --iso-8601=seconds|cut -f 1 -d '+')Z"
echo "post weight: $postWeight"
echo "post date: $postDate"
